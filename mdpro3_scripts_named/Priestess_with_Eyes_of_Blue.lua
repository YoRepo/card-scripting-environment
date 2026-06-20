--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 青色眼睛的巫女  (ID: 36734924)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「青色眼睛的巫女」的①②的效果1回合只能有1次使用其中任意1个。
-- ①：场上的表侧表示的这张卡成为效果的对象时才能发动。选自己场上1只效果怪兽送去墓地，从卡组把最多2只「青眼」怪兽加入手卡（同名卡最多1张）。
-- ②：这张卡在墓地存在的场合，以自己场上1只「青眼」怪兽为对象才能发动。那只怪兽回到持有者卡组，这张卡从墓地特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--青き眼の巫女
function c36734924.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36734924,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_BECOME_TARGET)
	e1:SetCountLimit(1,36734924)
	e1:SetCondition(c36734924.thcon)
	e1:SetTarget(c36734924.thtg)
	e1:SetOperation(c36734924.thop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(36734924,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,36734924)
	e2:SetTarget(c36734924.sptg)
	e2:SetOperation(c36734924.spop)
	c:RegisterEffect(e2)
end
function c36734924.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsContains(e:GetHandler())
end
function c36734924.tgfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and c:IsAbleToGrave()
end
function c36734924.thfilter(c)
	return c:IsSetCard(0xdd) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c36734924.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c36734924.tgfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c36734924.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c36734924.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=Duel.SelectMatchingCard(tp,c36734924.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=tg:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE) then
		local g=Duel.GetMatchingGroup(c36734924.thfilter,tp,LOCATION_DECK,0,nil)
		if g:GetCount()<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg1=g:SelectSubGroup(tp,aux.dncheck,false,1,2)
		Duel.SendtoHand(sg1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg1)
	end
end
function c36734924.spfilter(c,ft)
	return c:IsFaceup() and c:IsSetCard(0xdd) and c:IsAbleToDeck() and (ft>0 or c:GetSequence()<5)
end
function c36734924.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c36734924.spfilter(chkc,ft) end
	if chk==0 then return Duel.IsExistingTarget(c36734924.spfilter,tp,LOCATION_MZONE,0,1,nil,ft)
		and ft>-1 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c36734924.spfilter,tp,LOCATION_MZONE,0,1,1,nil,ft)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c36734924.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
