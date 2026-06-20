--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 凯尔柏克  (ID: 54878498)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level 4
-- ATK 1500 | DEF 1800
--
-- Effect Text:
-- 向这张卡攻击的怪兽回到持有者手卡。伤害计算适用。
--[[ __CARD_HEADER_END__ ]]

--ケルベク
function c54878498.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54878498,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c54878498.condition)
	e1:SetTarget(c54878498.target)
	e1:SetOperation(c54878498.operation)
	c:RegisterEffect(e1)
end
function c54878498.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler() and not Duel.GetAttacker():IsStatus(STATUS_BATTLE_DESTROYED)
end
function c54878498.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,Duel.GetAttacker(),1,0,0)
end
function c54878498.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if not a:IsRelateToBattle() then return end
	Duel.SendtoHand(a,nil,REASON_EFFECT)
end
