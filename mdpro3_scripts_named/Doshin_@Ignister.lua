--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 沉沉妖@火灵天星  (ID: 78751195)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Cyberse
-- Level 1
-- ATK 100 | DEF 800
-- Setcode: 309
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上有「@火灵天星」怪兽存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：以自己墓地1只电子界族连接怪兽为对象才能发动。那只怪兽回到额外卡组，从卡组把1张「“艾”慕融合」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ドシン＠イグニスター
function c78751195.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(78751195,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,78751195)
	e1:SetCondition(c78751195.spcon)
	e1:SetTarget(c78751195.sptg)
	e1:SetOperation(c78751195.spop)
	c:RegisterEffect(e1)
	--to extra
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(78751195,1))
	e2:SetCategory(CATEGORY_TOEXTRA+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,78751196)
	e2:SetTarget(c78751195.tetg)
	e2:SetOperation(c78751195.teop)
	c:RegisterEffect(e2)
end
function c78751195.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x135)
end
function c78751195.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c78751195.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c78751195.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c78751195.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c78751195.tefilter(c)
	return c:IsRace(RACE_CYBERSE) and c:IsType(TYPE_LINK) and c:IsAbleToExtra()
end
function c78751195.thfilter(c)
	return c:IsCode(59332125) and c:IsAbleToHand()
end
function c78751195.tetg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c78751195.tefilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c78751195.tefilter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c78751195.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c78751195.tefilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c78751195.teop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_EXTRA) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c78751195.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
