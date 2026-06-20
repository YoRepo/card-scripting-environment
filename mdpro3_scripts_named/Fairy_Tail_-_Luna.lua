--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 妖精传姬-辉夜  (ID: 86937530)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1850 | DEF 1000
-- Setcode: 475
--
-- Effect Text:
-- ①：这张卡召唤时才能发动。从卡组把1只攻击力1850的魔法师族怪兽加入手卡。
-- ②：自己·对方回合1次，以对方场上1只表侧表示怪兽为对象才能发动。对方可以把1张那只怪兽的同名卡从自身的卡组·额外卡组送去墓地让这个效果无效。没送去墓地的场合，这张卡和作为对象的怪兽回到手卡。
--[[ __CARD_HEADER_END__ ]]

--妖精伝姫－カグヤ
function c86937530.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86937530,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c86937530.target)
	e1:SetOperation(c86937530.operation)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(86937530,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetTarget(c86937530.thtg)
	e2:SetOperation(c86937530.thop)
	c:RegisterEffect(e2)
end
function c86937530.filter(c)
	return c:IsAttack(1850) and c:IsRace(RACE_SPELLCASTER) and c:IsAbleToHand()
end
function c86937530.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c86937530.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c86937530.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c86937530.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c86937530.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function c86937530.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(c86937530.thfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c86937530.thfilter,tp,0,LOCATION_MZONE,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,2,0,0)
end
function c86937530.cfilter(c,code)
	return c:IsCode(code) and c:IsAbleToGraveAsCost()
end
function c86937530.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	if Duel.IsChainDisablable(0) and tc:IsFaceup() then
		local g=Duel.GetMatchingGroup(c86937530.cfilter,tp,0,LOCATION_DECK+LOCATION_EXTRA,nil,tc:GetCode())
		local sel=1
		Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(86937530,2))
		if g:GetCount()>0 then
			sel=Duel.SelectOption(1-tp,1213,1214)
		else
			sel=Duel.SelectOption(1-tp,1214)+1
		end
		if sel==0 then
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
			local sg=g:Select(1-tp,1,1,nil)
			Duel.SendtoGrave(sg,REASON_EFFECT)
			Duel.NegateEffect(0)
			return
		end
	end
	local rg=Group.FromCards(c,tc)
	Duel.SendtoHand(rg,nil,REASON_EFFECT)
end
