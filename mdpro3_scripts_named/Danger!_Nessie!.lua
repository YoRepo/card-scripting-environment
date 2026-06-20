--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 未界域的尼斯水怪  (ID: 70711847)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Aqua
-- Level 7
-- ATK 1600 | DEF 2800
-- Setcode: 286
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：把手卡的这张卡给对方观看才能发动。从自己的全部手卡之中由对方随机选1张，自己把那张卡丢弃。那是「未界域的尼斯水怪」以外的场合，再从手卡把1只「未界域的尼斯水怪」特殊召唤，自己抽1张。
-- ②：这张卡从手卡丢弃的场合才能发动。从卡组把「未界域的尼斯水怪」以外的1张「未界域」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--未界域のネッシー
function c70711847.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70711847,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_HANDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c70711847.spcost)
	e1:SetTarget(c70711847.sptg)
	e1:SetOperation(c70711847.spop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(70711847,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DISCARD)
	e2:SetCountLimit(1,70711847)
	e2:SetTarget(c70711847.thtg)
	e2:SetOperation(c70711847.thop)
	c:RegisterEffect(e2)
end
function c70711847.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function c70711847.spfilter(c,e,tp)
	return c:IsCode(70711847) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c70711847.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil,REASON_EFFECT) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c70711847.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g:GetCount()<=0 then return end
	local tc=g:RandomSelect(1-tp,1):GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_DISCARD+REASON_EFFECT)~=0 and not tc:IsCode(70711847)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local spg=Duel.GetMatchingGroup(c70711847.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
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
function c70711847.thfilter(c)
	return c:IsSetCard(0x11e) and not c:IsCode(70711847) and c:IsAbleToHand()
end
function c70711847.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c70711847.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c70711847.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c70711847.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
