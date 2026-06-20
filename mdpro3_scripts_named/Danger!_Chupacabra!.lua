--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 未界域的卓柏卡布拉  (ID: 16209941)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1500 | DEF 400
-- Setcode: 286
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：把手卡的这张卡给对方观看才能发动。从自己的全部手卡之中由对方随机选1张，自己把那张卡丢弃。那是「未界域的卓柏卡布拉」以外的场合，再从手卡把1只「未界域的卓柏卡布拉」特殊召唤，自己抽1张。
-- ②：这张卡从手卡丢弃的场合，以「未界域的卓柏卡布拉」以外的自己墓地1只「未界域」怪兽为对象才能发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--未界域のチュパカブラ
function c16209941.initial_effect(c)
	--special summon (self)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16209941,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_HANDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c16209941.spcost)
	e1:SetTarget(c16209941.sptg)
	e1:SetOperation(c16209941.spop)
	c:RegisterEffect(e1)
	--special summon (grave)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(16209941,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DISCARD)
	e2:SetCountLimit(1,16209941)
	e2:SetTarget(c16209941.sptg2)
	e2:SetOperation(c16209941.spop2)
	c:RegisterEffect(e2)
end
function c16209941.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function c16209941.spfilter(c,e,tp)
	return c:IsCode(16209941) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c16209941.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil,REASON_EFFECT) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c16209941.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g:GetCount()<=0 then return end
	local tc=g:RandomSelect(1-tp,1):GetFirst()
	if Duel.SendtoGrave(tc,REASON_DISCARD+REASON_EFFECT)~=0 and not tc:IsCode(16209941)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local spg=Duel.GetMatchingGroup(c16209941.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
		if spg:GetCount()<=0 then return end
		local sg=spg
		if spg:GetCount()~=1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			sg=spg:Select(tp,1,1,nil)
		end
		Duel.BreakEffect()
		if Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)~=0 then
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
function c16209941.spfilter2(c,e,tp)
	return c:IsSetCard(0x11e) and not c:IsCode(16209941) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c16209941.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c16209941.spfilter2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c16209941.spfilter2,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c16209941.spfilter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c16209941.spop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
