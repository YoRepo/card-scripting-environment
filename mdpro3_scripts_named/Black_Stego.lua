--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 暗黑剑龙  (ID: 79409334)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 4
-- ATK 1200 | DEF 2000
--
-- Effect Text:
-- 这张卡被选择作为对方怪兽的攻击对象时，这张卡变成守备表示。
--[[ __CARD_HEADER_END__ ]]

--暗黒ステゴ
function c79409334.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79409334,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetTarget(c79409334.target)
	e1:SetOperation(c79409334.operation)
	c:RegisterEffect(e1)
end
function c79409334.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c79409334.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsPosition(POS_FACEUP_ATTACK) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
