--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 拒绝棉羊  (ID: 45025640)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 4
-- ATK 1000 | DEF 2500
--
-- Effect Text:
-- ①：这张卡的战斗发生的对对方的战斗伤害由自己代受。
-- ②：这张卡的战斗不让这张卡被破坏，让自己受到战斗伤害的场合发动。这张卡回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--ボイコットン
function c45025640.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetCondition(c45025640.rfcon)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c45025640.thcon)
	e2:SetTarget(c45025640.thtg)
	e2:SetOperation(c45025640.thop)
	c:RegisterEffect(e2)
end
function c45025640.rfcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c45025640.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep==tp and bit.band(r,REASON_BATTLE)~=0
		and (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c)
		and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c45025640.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c45025640.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
end
