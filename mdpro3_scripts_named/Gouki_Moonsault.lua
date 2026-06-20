--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 刚鬼 月面坠击兔  (ID: 20191720)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 1900 | DEF 0
-- Setcode: 252
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把手卡的这张卡给对方观看，以「刚鬼 月面坠击兔」以外的自己场上1只「刚鬼」怪兽为对象才能发动。这张卡从手卡特殊召唤，作为对象的怪兽回到持有者手卡。
-- ②：以自己墓地1只「刚鬼」连接怪兽为对象才能发动。那只怪兽回到额外卡组。那之后，可以从自己墓地选1只「刚鬼」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--剛鬼ムーンサルト
function c20191720.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20191720,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,20191720)
	e1:SetCost(c20191720.spcost)
	e1:SetTarget(c20191720.sptg)
	e1:SetOperation(c20191720.spop)
	c:RegisterEffect(e1)
	--to extra
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20191720,1))
	e2:SetCategory(CATEGORY_TOEXTRA)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,20191721)
	e2:SetTarget(c20191720.tdtg)
	e2:SetOperation(c20191720.tdop)
	c:RegisterEffect(e2)
end
function c20191720.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function c20191720.spfilter(c)
	return c:IsSetCard(0xfc) and c:IsFaceup() and c:IsAbleToHand() and not c:IsCode(20191720)
end
function c20191720.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c20191720.spfilter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c20191720.spfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c20191720.spfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c20191720.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
		end
	end
end
function c20191720.tdfilter(c)
	return c:IsSetCard(0xfc) and c:IsType(TYPE_LINK) and c:IsAbleToExtra()
end
function c20191720.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c20191720.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20191720.tdfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c20191720.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c20191720.thfilter(c)
	return c:IsSetCard(0xfc) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c20191720.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_EXTRA) then
		local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c20191720.thfilter),tp,LOCATION_GRAVE,0,nil)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(20191720,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
