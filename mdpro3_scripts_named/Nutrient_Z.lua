--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 体力增强剂 超级Z  (ID: 29389368)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己要受到2000以上的战斗伤害的场合，那次伤害计算时才能发动。自己回复4000基本分。
--[[ __CARD_HEADER_END__ ]]

--体力増強剤スーパーZ
function c29389368.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c29389368.condition)
	e1:SetTarget(c29389368.target)
	e1:SetOperation(c29389368.activate)
	c:RegisterEffect(e1)
end
function c29389368.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>=2000
end
function c29389368.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,4000)
end
function c29389368.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,4000,REASON_EFFECT)
end
