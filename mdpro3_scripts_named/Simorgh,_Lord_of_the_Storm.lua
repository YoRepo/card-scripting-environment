--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 烈风之霸者 斯摩夫  (ID: 95192919)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 8
-- ATK 2900 | DEF 2000
-- Setcode: 301
--
-- Effect Text:
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：上级召唤的这张卡不会成为对方的魔法·陷阱卡的效果的对象。
-- ②：魔法·陷阱卡的效果发动时，把自己场上1只鸟兽族·风属性怪兽解放，以对方场上1张卡为对象才能发动。那张卡回到持有者卡组。
-- ③：这张卡在墓地存在，自己的鸟兽族怪兽被战斗破坏时才能发动。这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--烈風の覇者シムルグ
function c95192919.initial_effect(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c95192919.tgcon)
	e1:SetValue(c95192919.tgval)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95192919,0))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,95192919)
	e2:SetCondition(c95192919.tdcon)
	e2:SetCost(c95192919.tdcost)
	e2:SetTarget(c95192919.tdtg)
	e2:SetOperation(c95192919.tdop)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(95192919,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,95192920)
	e3:SetCondition(c95192919.thcon)
	e3:SetTarget(c95192919.thtg)
	e3:SetOperation(c95192919.thop)
	c:RegisterEffect(e3)
end
function c95192919.tgcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c95192919.tgval(e,re,rp)
	return rp==1-e:GetHandlerPlayer() and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c95192919.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c95192919.costfilter(c,tp)
	return c:IsRace(RACE_WINDBEAST) and c:IsAttribute(ATTRIBUTE_WIND) and (c:IsControler(tp) or c:IsFaceup())
end
function c95192919.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c95192919.costfilter,1,nil,tp) end
	local sg=Duel.SelectReleaseGroup(tp,c95192919.costfilter,1,1,nil,tp)
	Duel.Release(sg,REASON_COST)
end
function c95192919.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c95192919.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function c95192919.cfilter(c,tp)
	return c:IsRace(RACE_WINDBEAST) and c:IsPreviousControler(tp)
end
function c95192919.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c95192919.cfilter,1,e:GetHandler(),tp)
end
function c95192919.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c95192919.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
