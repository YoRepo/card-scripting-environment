--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 燃烧拳击手 轮摆式移位拳王  (ID: 46804536)
-- Type: Monster / Effect / Xyz
-- Attribute: FIRE
-- Race: Warrior
-- Rank 4
-- ATK 2300 | DEF 1800
-- Setcode: 4228
--
-- Effect Text:
-- 4星怪兽×2
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡特殊召唤的场合才能发动。从卡组选1只4星以下的战士族·炎属性怪兽或者1张「燃烧拳」魔法·陷阱卡加入手卡或送去墓地。
-- ②：自己·对方回合可以发动。自己场上1个超量素材取除，以下效果适用。
-- ●这个回合中对方不能把自己场上的「燃烧拳击手」怪兽作为效果的对象。
--[[ __CARD_HEADER_END__ ]]

--BK キング・デンプシー
function c46804536.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46804536,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,46804536)
	e1:SetTarget(c46804536.thtg)
	e1:SetOperation(c46804536.thop)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46804536,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,46804537)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e2:SetTarget(c46804536.tgtg)
	e2:SetOperation(c46804536.tgop)
	c:RegisterEffect(e2)
end
function c46804536.thfilter(c)
	return (c:IsLevelBelow(4) and c:IsRace(RACE_WARRIOR) and c:IsAttribute(ATTRIBUTE_FIRE)
		or c:IsSetCard(0x2084) and c:IsType(TYPE_SPELL+TYPE_TRAP)) and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function c46804536.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c46804536.thfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c46804536.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,c46804536.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if not tc then return end
	if tc:IsAbleToHand() and (not tc:IsAbleToGrave() or Duel.SelectOption(tp,1190,1191)==0) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	else
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
function c46804536.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckRemoveOverlayCard(tp,1,0,1,REASON_EFFECT) end
end
function c46804536.tgop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.RemoveOverlayCard(tp,1,0,1,1,REASON_EFFECT)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1084))
		e1:SetValue(c46804536.tgval)
		e1:SetOwnerPlayer(tp)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c46804536.tgval(e,re,rp)
	return rp==1-e:GetOwnerPlayer()
end
