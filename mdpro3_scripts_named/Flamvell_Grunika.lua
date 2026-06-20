--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 炎狱龙人  (ID: 77372241)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dragon
-- Level 4
-- ATK 1700 | DEF 200
-- Setcode: 44
--
-- Effect Text:
-- 这张卡战斗破坏怪兽送去墓地时，给与对方基本分破坏怪兽的等级×200的数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--フレムベル・グルニカ
function c77372241.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77372241,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c77372241.damcon)
	e1:SetTarget(c77372241.damtg)
	e1:SetOperation(c77372241.damop)
	c:RegisterEffect(e1)
end
function c77372241.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	e:SetLabel(tc:GetLevel())
	return eg:GetCount()==1 and tc:GetReasonCard()==e:GetHandler()
		and tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE)
end
function c77372241.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel()*200)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel()*200)
end
function c77372241.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
