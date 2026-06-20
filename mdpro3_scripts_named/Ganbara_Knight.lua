--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 加把劲骑士  (ID: 24291651)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 0 | DEF 1800
--
-- Effect Text:
-- 场上表侧攻击表示存在的这张卡被选择作为攻击对象时，可以把这张卡的表示形式变成守备表示。
--[[ __CARD_HEADER_END__ ]]

--ガンバラナイト
function c24291651.initial_effect(c)
	--to defense
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24291651,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c24291651.poscon)
	e1:SetOperation(c24291651.posop)
	c:RegisterEffect(e1)
end
function c24291651.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c24291651.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
