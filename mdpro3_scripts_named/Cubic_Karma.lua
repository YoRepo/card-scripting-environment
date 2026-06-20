--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 方界业  (ID: 9659580)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 227
--
-- Effect Text:
-- ①：这张卡的发动时，可以以「方界胤 毗贾姆」以外的自己场上1只「方界」怪兽为对象。那个场合，从手卡·卡组把「方界胤
-- 毗贾姆」任意数量送去墓地。那之后，作为对象的怪兽的攻击力上升这个效果送去墓地的怪兽数量×800。
-- ②：对方回合「方界」怪兽的效果让「方界胤 毗贾姆」特殊召唤的场合发动。这张卡送去墓地，对方基本分变成一半。
-- ③：把墓地的这张卡除外才能发动。从卡组把1只「方界」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--方界業
function c9659580.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9659580.target)
	c:RegisterEffect(e1)
	--lp halve
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9659580,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c9659580.lpcon)
	e2:SetOperation(c9659580.lpop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(9659580,2))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c9659580.thtg)
	e3:SetOperation(c9659580.thop)
	c:RegisterEffect(e3)
end
function c9659580.tgfilter(c)
	return c:IsCode(15610297) and c:IsAbleToGrave()
end
function c9659580.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xe3) and not c:IsCode(15610297)
end
function c9659580.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c9659580.filter(chkc) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(c9659580.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c9659580.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(9659580,0)) then
		e:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_TOGRAVE)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetOperation(c9659580.activate)
		Duel.SelectTarget(tp,c9659580.filter,tp,LOCATION_MZONE,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c9659580.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c9659580.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,99,nil)
	if Duel.SendtoGrave(g,REASON_EFFECT)~=0 then
		local og=Duel.GetOperatedGroup()
		local n=og:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) and tc:IsFaceup() and n>0 then
			Duel.BreakEffect()
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(n*800)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
		end
	end
end
function c9659580.lpcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return Duel.GetTurnPlayer()~=tp and re:IsActiveType(TYPE_MONSTER) and rc and rc:IsSetCard(0xe3)
		and eg:IsExists(Card.IsCode,1,nil,15610297)
end
function c9659580.lpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SendtoGrave(c,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_GRAVE) then
		Duel.SetLP(1-tp,math.ceil(Duel.GetLP(1-tp)/2))
	end
end
function c9659580.thfilter(c)
	return c:IsSetCard(0xe3) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c9659580.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9659580.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c9659580.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c9659580.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
