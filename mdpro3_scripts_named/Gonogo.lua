--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 滚滚球  (ID: 59797187)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 3
-- ATK 1350 | DEF 1600
--
-- Effect Text:
-- 和这张卡进行战斗的对方怪兽在伤害步骤结束时变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--ゴロゴル
function c59797187.initial_effect(c)
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(59797187,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(aux.dsercon)
	e1:SetTarget(c59797187.target)
	e1:SetOperation(c59797187.operation)
	c:RegisterEffect(e1)
end
function c59797187.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=e:GetHandler():GetBattleTarget()
	if chk==0 then return tg and tg:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,tg,1,0,0)
end
function c59797187.operation(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() and bc:IsFaceup() then
		Duel.ChangePosition(bc,POS_FACEDOWN_DEFENSE)
	end
end
