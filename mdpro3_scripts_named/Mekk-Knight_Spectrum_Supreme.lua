--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 星痕之机界骑士  (ID: 38502358)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Cyberse
-- ATK 3000 | LINK
-- Setcode: 268
--
-- Effect Text:
-- 「机界骑士」怪兽2只以上
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：和这张卡相同纵列没有其他卡存在的场合，这张卡可以直接攻击。
-- ②：额外怪兽区域的这张卡的所连接区没有怪兽存在的场合，这张卡不会被效果破坏，不会成为对方的效果的对象。
-- ③：把和这张卡相同纵列1张其他的自己的卡送去墓地才能发动。从卡组把1只「机界骑士」怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--星痕の機界騎士
function c38502358.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x10c),2)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c38502358.dircon)
	c:RegisterEffect(e1)
	--cannot be target/effect indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c38502358.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(38502358,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,38502358)
	e4:SetCost(c38502358.spcost)
	e4:SetTarget(c38502358.sptg)
	e4:SetOperation(c38502358.spop)
	c:RegisterEffect(e4)
end
function c38502358.dircon(e)
	return e:GetHandler():GetColumnGroupCount()==0
end
function c38502358.indcon(e)
	local c=e:GetHandler()
	return c:GetSequence()>4 and c:IsType(TYPE_LINK) and c:GetLinkedGroupCount()==0
end
function c38502358.spcfilter(c,g,tp)
	return g:IsContains(c) and c:IsAbleToGraveAsCost() and Duel.GetMZoneCount(tp,c)>0
end
function c38502358.spfilter(c,e,tp)
	return c:IsSetCard(0x10c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c38502358.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local cg=c:GetColumnGroup()
	if chk==0 then return Duel.IsExistingMatchingCard(c38502358.spcfilter,tp,LOCATION_ONFIELD,0,1,c,cg,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c38502358.spcfilter,tp,LOCATION_ONFIELD,0,1,1,c,cg,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c38502358.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c38502358.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c38502358.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c38502358.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
