--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 海晶少女波动  (ID: 52945066)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 299
--
-- Effect Text:
-- 自己场上有连接3以上的「海晶少女」怪兽存在的场合，这张卡的发动从手卡也能用。
-- ①：自己场上有「海晶少女」连接怪兽存在的场合，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽的效果直到回合结束时无效。自己场上有连接2以上的「海晶少女」怪兽存在的场合，再让自己场上的全部表侧表示怪
-- 兽直到回合结束时不受对方的效果影响。
--[[ __CARD_HEADER_END__ ]]

--海晶乙女波動
function c52945066.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCondition(c52945066.con)
	e1:SetTarget(c52945066.target)
	e1:SetOperation(c52945066.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(52945066,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c52945066.handcon)
	c:RegisterEffect(e2)
end
function c52945066.ccfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x12b) and c:IsType(TYPE_LINK)
end
function c52945066.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c52945066.ccfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c52945066.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and aux.NegateMonsterFilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(aux.NegateMonsterFilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
	Duel.SelectTarget(tp,aux.NegateMonsterFilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c52945066.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x12b) and c:IsLinkAbove(2)
end
function c52945066.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsCanBeDisabledByEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local g1=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
		if Duel.IsExistingMatchingCard(c52945066.cfilter,tp,LOCATION_MZONE,0,1,nil) and g1:GetCount()>0 then
			Duel.BreakEffect()
			local nc=g1:GetFirst()
			while nc do
				local e3=Effect.CreateEffect(c)
				e3:SetType(EFFECT_TYPE_SINGLE)
				e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
				e3:SetRange(LOCATION_MZONE)
				e3:SetCode(EFFECT_IMMUNE_EFFECT)
				e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
				e3:SetValue(c52945066.efilter)
				e3:SetOwnerPlayer(tp)
				nc:RegisterEffect(e3)
				nc=g1:GetNext()
			end
		end
	end
end
function c52945066.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c52945066.hcfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x12b) and c:IsLinkAbove(3)
end
function c52945066.handcon(e)
	return Duel.IsExistingMatchingCard(c52945066.hcfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
