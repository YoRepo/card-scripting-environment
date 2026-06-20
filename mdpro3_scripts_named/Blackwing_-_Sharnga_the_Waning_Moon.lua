--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 黑羽-下弦之光弓鸟  (ID: 54594017)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Winged Beast
-- Level 2
-- ATK 500 | DEF 500
-- Setcode: 51
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果在决斗中只能使用1次。
-- ①：场上有攻击力2000以上的怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：自己·对方回合，自己场上有「黑羽」同调怪兽存在的场合，把墓地的这张卡除外，以对方场上1张表侧表示卡为对象才能发动。那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--BF－下弦のサルンガ
function c54594017.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,54594017+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c54594017.spcon)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCountLimit(1,54594018+EFFECT_COUNT_CODE_DUEL)
	e2:SetCondition(c54594017.descon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c54594017.destg)
	e2:SetOperation(c54594017.desop)
	c:RegisterEffect(e2)
end
function c54594017.filter(c)
	return c:IsAttackAbove(2000) and c:IsFaceup()
end
function c54594017.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c54594017.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c54594017.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x33) and c:IsType(TYPE_SYNCHRO)
end
function c54594017.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c54594017.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c54594017.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c54594017.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
