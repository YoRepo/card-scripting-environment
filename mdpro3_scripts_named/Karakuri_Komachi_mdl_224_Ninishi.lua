--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 机巧小町 二二四  (ID: 24621460)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Machine
-- Level 3
-- ATK 0 | DEF 1900
-- Setcode: 17
--
-- Effect Text:
-- 这张卡可以攻击的场合必须作出攻击。场上表侧表示存在的这张卡被选择作为攻击对象时，这张卡的表示形式变更。只要这张卡在场上表侧表示存在，自己的主要阶段时只有1次，自己在通常召唤外加上可以把1只名字带有「机
-- 巧」的怪兽召唤。
--[[ __CARD_HEADER_END__ ]]

--カラクリ小町 弐弐四
function c24621460.initial_effect(c)
	--must attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MUST_ATTACK)
	c:RegisterEffect(e1)
	--pos change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(24621460,0))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetOperation(c24621460.posop)
	c:RegisterEffect(e3)
	--extra summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(24621460,1))
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e4:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x11))
	c:RegisterEffect(e4)
end
function c24621460.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end
