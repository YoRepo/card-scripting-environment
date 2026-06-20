--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 圆盘斗技场 兽带斗神环形擂台  (ID: 84792926)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 377
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，可以从卡组把1只「兽带斗神」怪兽加入手卡。
-- ②：1回合1次，自己怪兽被战斗破坏的场合，可以作为代替从卡组把1张「兽带斗神」卡或者「无尽机关 银星系统」送去墓地。
-- ③：1回合1次，自己或者对方的怪兽被战斗破坏送去墓地时，以自己墓地1只「兽带斗神」怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--円盤闘技場セリオンズ・リング
function c84792926.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,84792926+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c84792926.activate)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c84792926.destg)
	e2:SetValue(c84792926.desvalue)
	e2:SetOperation(c84792926.desop)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(84792926,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_FZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetCountLimit(1)
	e3:SetTarget(c84792926.thtg)
	e3:SetOperation(c84792926.thop)
	c:RegisterEffect(e3)
end
function c84792926.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x179) and c:IsAbleToHand()
end
function c84792926.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c84792926.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(84792926,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c84792926.dfilter(c,tp)
	return c:IsControler(tp) and c:IsReason(REASON_BATTLE)
end
function c84792926.repfilter(c)
	return (c:IsSetCard(0x179) or c:IsCode(21887075)) and c:IsAbleToGrave()
end
function c84792926.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c84792926.dfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c84792926.repfilter,tp,LOCATION_DECK,0,1,nil) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c84792926.desvalue(e,c)
	return c:IsControler(e:GetHandlerPlayer()) and c:IsReason(REASON_BATTLE)
end
function c84792926.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c84792926.repfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_REPLACE)
end
function c84792926.filter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE)
end
function c84792926.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c84792926.thfilter(chkc) end
	if chk==0 then return eg:IsExists(c84792926.filter,1,nil)
		and Duel.IsExistingTarget(c84792926.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c84792926.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c84792926.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
