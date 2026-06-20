--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 天威龙-大同蟠龙  (ID: 23431858)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Wyrm
-- Level 7
-- ATK 1500 | DEF 2500
-- Setcode: 300
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上没有效果怪兽存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：自己场上有效果怪兽以外的表侧表示怪兽存在的场合，把手卡·墓地的这张卡除外，以对方场上1张卡为对象才能发动。那张卡回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--天威龍－ヴィシュダ
function c23431858.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23431858,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,23431858)
	e1:SetCondition(c23431858.spcon)
	e1:SetTarget(c23431858.sptg)
	e1:SetOperation(c23431858.spop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23431858,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCountLimit(1,23431859)
	e2:SetCondition(c23431858.thcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c23431858.thtg)
	e2:SetOperation(c23431858.thop)
	c:RegisterEffect(e2)
end
function c23431858.spcfilter(c)
	return c:IsType(TYPE_EFFECT) and c:IsFaceup()
end
function c23431858.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c23431858.spcfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c23431858.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c23431858.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c23431858.thcfilter(c)
	return not c:IsType(TYPE_EFFECT) and c:IsFaceup()
end
function c23431858.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c23431858.thcfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c23431858.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c23431858.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
