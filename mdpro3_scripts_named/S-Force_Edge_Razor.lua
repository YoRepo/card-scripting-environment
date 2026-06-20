--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 治安战警队 拔刃者  (ID: 91864689)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Cyberse
-- Level 4
-- ATK 1500 | DEF 1300
-- Setcode: 342
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合才能发动。从手卡把「治安战警队 拔刃者」以外的1只「治安战警队」怪兽攻击表示特殊召唤。
-- ②：只要这张卡在怪兽区域存在，自己的「治安战警队」怪兽的正对面的对方怪兽不能作为连接3以上的怪兽的连接素材。
--[[ __CARD_HEADER_END__ ]]

--S－Force エッジ・レイザー
function c91864689.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91864689,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,91864689)
	e1:SetTarget(c91864689.sptg)
	e1:SetOperation(c91864689.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--cannot be used as material
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(c91864689.linklimit)
	e3:SetTarget(c91864689.matlimit)
	c:RegisterEffect(e3)
end
function c91864689.spfilter(c,e,tp)
	return c:IsSetCard(0x156) and not c:IsCode(91864689)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end
function c91864689.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c91864689.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c91864689.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c91864689.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
function c91864689.linklimit(e,c)
	return c:IsLinkAbove(3)
end
function c91864689.matfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x156) and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function c91864689.matlimit(e,c)
	local face=c:GetColumnGroup()
	return face:IsExists(c91864689.matfilter,1,nil,e:GetHandlerPlayer())
end
