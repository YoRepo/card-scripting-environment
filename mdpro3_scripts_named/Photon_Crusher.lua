--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 光子粉碎者  (ID: 1362589)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 2000 | DEF 0
-- Setcode: 85
--
-- Effect Text:
-- ①：这张卡攻击的场合，伤害步骤结束时变成守备表示。
--[[ __CARD_HEADER_END__ ]]

--フォトン・クラッシャー
function c1362589.initial_effect(c)
	--to defense
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c1362589.poscon)
	e1:SetOperation(c1362589.posop)
	c:RegisterEffect(e1)
end
function c1362589.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and e:GetHandler():IsRelateToBattle()
end
function c1362589.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsAttackPos() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
