--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 钢针螯  (ID: 98162242)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 5
-- ATK 1700 | DEF 1700
--
-- Effect Text:
-- 这张卡战斗破坏怪兽并将其送去墓地时，对对方基本分造成数值等同于被破坏怪兽等级×500点的伤害。
--[[ __CARD_HEADER_END__ ]]

--ニードルバンカー
function c98162242.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98162242,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCondition(c98162242.damcon)
	e1:SetTarget(c98162242.damtg)
	e1:SetOperation(c98162242.damop)
	c:RegisterEffect(e1)
end
function c98162242.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsReason(REASON_BATTLE) and bc:IsType(TYPE_MONSTER)
end
function c98162242.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local bc=e:GetHandler():GetBattleTarget()
	local dam=bc:GetLevel()*500
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c98162242.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
