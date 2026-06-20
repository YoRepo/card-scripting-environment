--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 净琉璃朋克惊愕梨割  (ID: 70070211)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 369
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以对方场上盖放的1张卡为对象才能发动。那张卡破坏。自己场上有「朋克」怪兽存在的场合，也能作为代替以对方场上1张表侧表示的卡为对象。
--[[ __CARD_HEADER_END__ ]]

--Jo－P.U.N.K.ナシワリ・サプライズ
function c70070211.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1,70070211+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c70070211.destg)
	e1:SetOperation(c70070211.desop)
	c:RegisterEffect(e1)
end
function c70070211.filter(c,check)
	return c:IsFacedown() or c:IsFaceup() and check
end
function c70070211.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x171)
end
function c70070211.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local check=Duel.IsExistingMatchingCard(c70070211.cfilter,tp,LOCATION_MZONE,0,1,nil)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c70070211.filter(chkc,check) end
	if chk==0 then return Duel.IsExistingTarget(c70070211.filter,tp,0,LOCATION_ONFIELD,1,nil,check) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c70070211.filter,tp,0,LOCATION_ONFIELD,1,1,nil,check)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c70070211.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
