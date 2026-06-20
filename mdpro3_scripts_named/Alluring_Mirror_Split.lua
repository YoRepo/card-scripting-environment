--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 魅惑的两镜相照  (ID: 92881099)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己的「鹰身女郎」或者「鹰身女郎三姐妹」被战斗破坏时才能发动。原本卡名和那只怪兽不同的1只「鹰身」怪兽从卡组特殊召唤。
-- ②：场上的这张卡被对方的效果或者自己的「鹰身」卡的效果破坏的场合，以自己墓地1只「鹰身」怪兽为对象发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魅惑の合わせ鏡
function c92881099.initial_effect(c)
	aux.AddCodeList(c,12206212)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92881099,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,92881099)
	e2:SetCondition(c92881099.spcon)
	e2:SetTarget(c92881099.sptg)
	e2:SetOperation(c92881099.spop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,92881100)
	e3:SetCondition(c92881099.spcon2)
	e3:SetTarget(c92881099.sptg2)
	e3:SetOperation(c92881099.spop2)
	c:RegisterEffect(e3)
end
function c92881099.cfilter(c,tp)
	return (c:GetPreviousCodeOnField()==76812113 or c:GetPreviousCodeOnField()==12206212)
		and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
end
function c92881099.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:FilterCount(c92881099.cfilter,nil,tp)>0
end
function c92881099.spfilter(c,e,tp,g)
	local diff=true
	for tc in aux.Next(g) do
		if c:IsOriginalCodeRule(tc:GetOriginalCodeRule()) then
			diff=false
			break
		end
	end
	return diff and c:IsSetCard(0x64) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c92881099.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g0=eg:Filter(c92881099.cfilter,nil,tp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c92881099.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,g0) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c92881099.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g0=eg:Filter(c92881099.cfilter,nil,tp)
	local g=Duel.SelectMatchingCard(tp,c92881099.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,g0)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c92881099.spfilter2(c,e,tp)
	return c:IsSetCard(0x64) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c92881099.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and (rp==1-tp or (rp==tp and re:GetHandler():IsSetCard(0x64))) and c:IsPreviousControler(tp)
end
function c92881099.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c92881099.spfilter2(chkc,e,tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c92881099.spfilter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c92881099.spop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
