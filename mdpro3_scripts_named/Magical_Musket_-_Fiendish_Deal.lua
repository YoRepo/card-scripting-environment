--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 魔弹-恶魔交易  (ID: 92534075)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 264
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：只要这张卡在魔法与陷阱区域存在，自己场上的「魔弹」怪兽不会被效果破坏。
-- ②：这张卡被对方的效果送去墓地的场合才能发动。从自己的卡组·墓地选「魔弹-恶魔交易」以外的1张「魔弹」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--魔弾－デビルズ・ディール
function c92534075.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,92534075+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x108))
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(92534075,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c92534075.thcon)
	e3:SetTarget(c92534075.thtg)
	e3:SetOperation(c92534075.thop)
	c:RegisterEffect(e3)
end
function c92534075.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsReason(REASON_EFFECT) and c:IsPreviousControler(tp)
end
function c92534075.thfilter(c)
	return c:IsSetCard(0x108) and not c:IsCode(92534075) and c:IsAbleToHand()
end
function c92534075.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92534075.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c92534075.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c92534075.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
