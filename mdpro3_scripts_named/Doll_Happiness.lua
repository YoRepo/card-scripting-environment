--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 人偶的幸福  (ID: 71595845)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，从卡组把1只「德梅特爷爷」或者「玩具盒」加入手卡。
-- ②：只要自己场上有「珂珑公主」存在，对方不能选择攻击力或守备力是0的怪兽作为攻击对象。
-- ③：1回合1次，可以发动。选自己的手卡·场上1只怪兽破坏，从卡组把1张「人偶怪兽」卡送去墓地。这个回合，自己不是超量怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--人形の幸福
function c71595845.initial_effect(c)
	aux.AddCodeList(c,44190146,81587028,75574498)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,71595845+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c71595845.target)
	e1:SetOperation(c71595845.activate)
	c:RegisterEffect(e1)
	--atklimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c71595845.atkcon)
	e2:SetValue(c71595845.atkval)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c71595845.tgtg)
	e3:SetOperation(c71595845.tgop)
	c:RegisterEffect(e3)
end
function c71595845.filter(c)
	return c:IsCode(44190146,81587028) and c:IsAbleToHand()
end
function c71595845.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c71595845.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c71595845.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c71595845.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c71595845.atkfilter(c)
	return c:IsCode(75574498) and c:IsFaceup()
end
function c71595845.atkcon(e)
	return Duel.IsExistingMatchingCard(c71595845.atkfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c71595845.atkval(e,c)
	return c:IsFaceup() and (c:IsAttack(0) or c:IsDefense(0))
end
function c71595845.tgfilter(c)
	return c:IsAbleToGrave() and c:IsSetCard(0x15a)
end
function c71595845.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c71595845.tgfilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE+LOCATION_HAND,0,1,nil,TYPE_MONSTER) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,tp,LOCATION_MZONE+LOCATION_HAND)
end
function c71595845.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_MZONE+LOCATION_HAND,0,1,1,nil,TYPE_MONSTER)
	if Duel.Destroy(g,REASON_EFFECT) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		g=Duel.SelectMatchingCard(tp,c71595845.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c71595845.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c71595845.splimit(e,c)
	return not c:IsType(TYPE_XYZ) and c:IsLocation(LOCATION_EXTRA)
end
