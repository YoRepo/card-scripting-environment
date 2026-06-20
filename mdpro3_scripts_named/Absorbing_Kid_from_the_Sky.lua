--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 吸收天儿  (ID: 49771608)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1300 | DEF 1000
--
-- Effect Text:
-- 这张卡战斗破坏怪兽并将其送去墓地时，自己回复被破坏的怪兽等级×300基本分。
--[[ __CARD_HEADER_END__ ]]

--吸収天児
function c49771608.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49771608,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCondition(c49771608.condition)
	e1:SetTarget(c49771608.target)
	e1:SetOperation(c49771608.operation)
	c:RegisterEffect(e1)
end
function c49771608.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
end
function c49771608.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local rec=e:GetHandler():GetBattleTarget():GetLevel()*300
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c49771608.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
