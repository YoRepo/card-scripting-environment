--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 战华盟将-双龙  (ID: 65711558)
-- Type: Monster / Effect / Link
-- Attribute: WIND
-- Race: Beast-Warrior
-- ATK 1100 | LINK
-- Setcode: 311
--
-- Effect Text:
-- 包含风属性「战华」怪兽的兽战士族怪兽2只
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：这张卡连接召唤成功的场合才能发动。从卡组把1张「战华」卡加入手卡。
-- ②：自己场上的「战华」怪兽的攻击力·守备力上升500。
-- ③：从自己的手卡·场上把1张卡送去墓地，以对方场上1张表侧表示的卡为对象才能发动。那张卡回到持有者手卡。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--戦華盟将－双龍
function c65711558.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_BEASTWARRIOR),2,2,c65711558.lcheck)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65711558,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,65711558)
	e1:SetCondition(c65711558.srcon)
	e1:SetTarget(c65711558.srtg)
	e1:SetOperation(c65711558.srop)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c65711558.atktg)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(65711558,1))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e4:SetCountLimit(1,65711559)
	e4:SetCost(c65711558.thcost)
	e4:SetTarget(c65711558.thtg)
	e4:SetOperation(c65711558.thop)
	c:RegisterEffect(e4)
end
function c65711558.matfilter(c)
	return c:IsLinkAttribute(ATTRIBUTE_WIND) and c:IsLinkSetCard(0x137)
end
function c65711558.lcheck(g,lc)
	return g:IsExists(c65711558.matfilter,1,nil)
end
function c65711558.srcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c65711558.srfilter(c)
	return c:IsSetCard(0x137) and c:IsAbleToHand()
end
function c65711558.srtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65711558.srfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65711558.srop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c65711558.srfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c65711558.atktg(e,c)
	return c:IsSetCard(0x137)
end
function c65711558.tgfilter(c,ec)
	return c65711558.thfilter(c) and c:GetEquipTarget()~=ec
end
function c65711558.costfilter(c,tp)
	return c:IsAbleToGraveAsCost() and Duel.IsExistingTarget(c65711558.tgfilter,tp,0,LOCATION_ONFIELD,1,nil,c)
end
function c65711558.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65711558.costfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c65711558.costfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c65711558.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function c65711558.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c65711558.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c65711558.thfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c65711558.thfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c65711558.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
