--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 苍穹之机界骑士  (ID: 20537097)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Psychic
-- Level 5
-- ATK 2000 | DEF 2500
-- Setcode: 268
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：相同纵列有卡2张以上存在的场合，这张卡可以从手卡往那个纵列的自己场上特殊召唤。
-- ②：这张卡从手卡的召唤·特殊召唤成功的场合才能发动。把和这张卡相同纵列的对方的卡数量的「苍穹之机界骑士」以外的「机界骑士」怪兽从卡组加入手卡（同名卡最多1张）。
--[[ __CARD_HEADER_END__ ]]

--蒼穹の機界騎士
function c20537097.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,20537097+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c20537097.hspcon)
	e1:SetValue(c20537097.hspval)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20537097,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,20537098)
	e2:SetTarget(c20537097.thtg)
	e2:SetOperation(c20537097.thop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c20537097.thcon)
	c:RegisterEffect(e3)
end
function c20537097.cfilter(c)
	return c:GetColumnGroupCount()>0
end
function c20537097.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local zone=0
	local lg=Duel.GetMatchingGroup(c20537097.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	for tc in aux.Next(lg) do
		zone=bit.bor(zone,tc:GetColumnZone(LOCATION_MZONE,tp))
	end
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function c20537097.hspval(e,c)
	local tp=c:GetControler()
	local zone=0
	local lg=Duel.GetMatchingGroup(c20537097.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	for tc in aux.Next(lg) do
		zone=bit.bor(zone,tc:GetColumnZone(LOCATION_MZONE,tp))
	end
	return 0,zone
end
function c20537097.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND)
end
function c20537097.thfilter(c)
	return c:IsSetCard(0x10c) and c:IsType(TYPE_MONSTER) and not c:IsCode(20537097) and c:IsAbleToHand()
end
function c20537097.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c20537097.thfilter,tp,LOCATION_DECK,0,nil)
	local ct=c:GetColumnGroup():FilterCount(Card.IsControler,nil,1-tp)
	if c:IsControler(1-tp) then ct=ct+1 end
	if chk==0 then return c:IsRelateToEffect(e) and ct>0 and g:GetClassCount(Card.GetCode)>=ct end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,ct,tp,LOCATION_DECK)
end
function c20537097.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c20537097.thfilter,tp,LOCATION_DECK,0,nil)
	local ct=c:GetColumnGroup():FilterCount(Card.IsControler,nil,1-tp)
	if c:IsControler(1-tp) then ct=ct+1 end
	if ct<=0 or g:GetClassCount(Card.GetCode)<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local hg=g:SelectSubGroup(tp,aux.dncheck,false,ct,ct)
	Duel.SendtoHand(hg,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,hg)
end
