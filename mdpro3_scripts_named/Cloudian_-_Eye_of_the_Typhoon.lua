--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 云魔物-台风眼  (ID: 57610714)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Aqua
-- Level 8
-- ATK 3000 | DEF 1000
-- Setcode: 24
--
-- Effect Text:
-- 这张卡不会被战斗破坏。这张卡表侧守备表示在场上存在的场合，这张卡破坏。这张卡的攻击宣言时，把名字带有「云魔物」的卡以外的全部表侧表示怪兽的表示形式改变。
--[[ __CARD_HEADER_END__ ]]

--雲魔物－アイ・オブ・ザ・タイフーン
function c57610714.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--selfdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c57610714.sdcon)
	c:RegisterEffect(e2)
	--pos Change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(57610714,0))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetOperation(c57610714.posop)
	c:RegisterEffect(e3)
end
function c57610714.sdcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE)
end
function c57610714.filter(c)
	return c:IsFaceup() and not c:IsSetCard(0x18)
end
function c57610714.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c57610714.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
end
