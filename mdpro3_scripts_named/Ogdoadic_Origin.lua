--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 溟界的渊源  (ID: 60448701)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 353
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上的表侧表示的爬虫类族怪兽被战斗或者对方的效果破坏的场合，以对方场上1张卡为对象才能发动。那张卡送去墓地。
-- ②：场地区域的这张卡被对方的效果破坏的场合才能发动。把自己墓地的爬虫类族怪兽种类数量的卡从对方卡组上面送去墓地。
--[[ __CARD_HEADER_END__ ]]

--溟界の淵源
function c60448701.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60448701,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCountLimit(1,60448701)
	e2:SetCondition(c60448701.tgcon1)
	e2:SetTarget(c60448701.tgtg1)
	e2:SetOperation(c60448701.tgop1)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(60448701,1))
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,60448702)
	e3:SetCondition(c60448701.tgcon2)
	e3:SetTarget(c60448701.tgtg2)
	e3:SetOperation(c60448701.tgop2)
	c:RegisterEffect(e3)
end
function c60448701.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousRaceOnField()&RACE_REPTILE~=0
		and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)
end
function c60448701.tgcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c60448701.cfilter,1,nil,tp)
end
function c60448701.tgtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() and chkc:IsAbleToGrave() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToGrave,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToGrave,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c60448701.tgop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
function c60448701.tgcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsReason(REASON_EFFECT)
		and c:IsPreviousLocation(LOCATION_FZONE) and c:IsPreviousControler(tp)
end
function c60448701.tgtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_GRAVE,0,nil,RACE_REPTILE):GetClassCount(Card.GetCode)
	if chk==0 then return ct>0 and Duel.IsPlayerCanDiscardDeck(1-tp,ct) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,ct)
end
function c60448701.tgop2(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_GRAVE,0,nil,RACE_REPTILE):GetClassCount(Card.GetCode)
	Duel.DiscardDeck(1-tp,ct,REASON_EFFECT)
end
