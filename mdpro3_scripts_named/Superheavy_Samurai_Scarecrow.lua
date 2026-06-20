--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 超重武者 案山子-C  (ID: 33918636)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Machine
-- ATK 0 | LINK
-- Setcode: 154
--
-- Effect Text:
-- 「超重武者」怪兽1只
-- 这个卡名的②的效果1回合只能使用1次。这张卡不能作为连接素材。
-- ①：自己墓地没有魔法·陷阱卡存在的场合，这张卡的战斗发生的对自己的战斗伤害变成0。
-- ②：自己墓地没有魔法·陷阱卡存在的场合，从手卡丢弃1只怪兽，以自己墓地1只「超重武者」怪兽为对象才能发动。那只怪兽在作为这张卡所连接区的自己场上守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--超重武者カカ－C
function c33918636.initial_effect(c)
	c:EnableReviveLimit()
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x9a),1,1)
	--cannot be link material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--no damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c33918636.condition)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33918636,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,33918636)
	e3:SetCondition(c33918636.condition)
	e3:SetCost(c33918636.spcost)
	e3:SetTarget(c33918636.sptg)
	e3:SetOperation(c33918636.spop)
	c:RegisterEffect(e3)
end
function c33918636.condition(e)
	return Duel.GetMatchingGroupCount(Card.IsType,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,TYPE_SPELL+TYPE_TRAP)==0
end
function c33918636.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c33918636.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33918636.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c33918636.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c33918636.spfilter(c,e,tp,zone)
	return c:IsSetCard(0x9a) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE,tp,zone)
end
function c33918636.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local zone=bit.band(e:GetHandler():GetLinkedZone(tp),0x1f)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c33918636.spfilter(chkc,e,tp,zone) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c33918636.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,zone) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c33918636.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,zone)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c33918636.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local zone=bit.band(e:GetHandler():GetLinkedZone(tp),0x1f)
	if tc:IsRelateToEffect(e) and zone~=0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE,zone)
	end
end
