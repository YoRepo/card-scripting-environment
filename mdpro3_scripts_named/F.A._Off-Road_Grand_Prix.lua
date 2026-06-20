--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 方程式运动员越野大奖赛  (ID: 2144946)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 263
--
-- Effect Text:
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：只要这张卡在场地区域存在，场上的「方程式运动员」怪兽的等级只在主要阶段内上升2星。
-- ②：自己的「方程式运动员」怪兽被战斗破坏时才能发动。对方手卡随机选1张丢弃。
-- ③：场上的表侧表示的这张卡被效果破坏的场合才能发动。从卡组把「方程式运动员越野大奖赛」以外的1张「方程式运动员」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--F.A.オフロードGP
function c2144946.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--lv up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_LEVEL)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x107))
	e2:SetValue(2)
	e2:SetCondition(c2144946.lvcon)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(2144946,0))
	e3:SetCategory(CATEGORY_HANDES)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1,2144946)
	e3:SetCondition(c2144946.descon)
	e3:SetTarget(c2144946.destg)
	e3:SetOperation(c2144946.desop)
	c:RegisterEffect(e3)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(2144946,1))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,2144947)
	e4:SetCondition(c2144946.thcon2)
	e4:SetTarget(c2144946.thtg2)
	e4:SetOperation(c2144946.thop2)
	c:RegisterEffect(e4)
end
function c2144946.lvcon(e)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
end
function c2144946.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousSetCard(0x107)
end
function c2144946.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c2144946.cfilter,1,nil,tp)
end
function c2144946.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,0,0,1-tp,1)
end
function c2144946.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
end
function c2144946.thcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
end
function c2144946.thfilter2(c)
	return c:IsSetCard(0x107) and not c:IsCode(2144946) and c:IsAbleToHand()
end
function c2144946.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2144946.thfilter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c2144946.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c2144946.thfilter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
