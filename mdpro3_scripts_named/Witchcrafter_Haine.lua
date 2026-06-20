--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 魔女术工匠·服装女巫  (ID: 84523092)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 7
-- ATK 2400 | DEF 1000
-- Setcode: 296
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，自己场上的其他的魔法师族怪兽不会成为对方的效果的对象。
-- ②：从手卡丢弃1张魔法卡，以对方场上1张表侧表示的卡为对象才能发动。那张卡破坏。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--ウィッチクラフト・ハイネ
function c84523092.initial_effect(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c84523092.tgtg)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84523092,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,84523092)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCost(c84523092.descost)
	e2:SetTarget(c84523092.destg)
	e2:SetOperation(c84523092.desop)
	c:RegisterEffect(e2)
end
function c84523092.tgtg(e,c)
	return c~=e:GetHandler() and c:IsRace(RACE_SPELLCASTER)
end
function c84523092.costfilter(c,tp)
	if c:IsLocation(LOCATION_HAND) then return c:IsType(TYPE_SPELL) and c:IsDiscardable() end
	return c:IsFaceup() and c:IsAbleToGraveAsCost() and c:IsHasEffect(83289866,tp)
end
function c84523092.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84523092.costfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,1,nil,tp) end
	local g=Duel.GetMatchingGroup(c84523092.costfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local tc=g:Select(tp,1,1,nil):GetFirst()
	local te=tc:IsHasEffect(83289866,tp)
	if te then
		te:UseCountLimit(tp)
		Duel.SendtoGrave(tc,REASON_COST)
	else
		Duel.SendtoGrave(tc,REASON_COST+REASON_DISCARD)
	end
end
function c84523092.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsFaceup() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c84523092.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
