--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 发条杂耍人  (ID: 85682655)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level 4
-- ATK 1700 | DEF 1000
-- Setcode: 88
--
-- Effect Text:
-- 这张卡和对方怪兽进行战斗的场合，可以把那只对方怪兽在伤害计算后破坏。这个效果只在这张卡在场上表侧表示存在能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ゼンマイジャグラー
function c85682655.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(85682655,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLED)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetTarget(c85682655.target)
	e1:SetOperation(c85682655.operation)
	c:RegisterEffect(e1)
end
function c85682655.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetAttacker()
	if tc==e:GetHandler() then tc=Duel.GetAttackTarget() end
	if chk==0 then return tc and tc:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c85682655.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc==e:GetHandler() then tc=Duel.GetAttackTarget() end
	if tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
