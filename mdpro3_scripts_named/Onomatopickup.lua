--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 拟声选择  (ID: 85119159)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 314
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张，这个卡名的②的效果1回合只能使用1次。
-- ①：作为这张卡的发动时的效果处理，可以从卡组把「拟声选择」以外的1张「拟声」卡加入手卡。
-- ②：以自己场上的「刷拉拉」、「我我我」、「隆隆隆」、「怒怒怒」怪兽之内任意1只为对象才能发动。自己场上的全部怪兽的等级直到回合结束时变成和作为对象的怪兽相同等级。
--[[ __CARD_HEADER_END__ ]]

--オノマト選択
function c85119159.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,85119159+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c85119159.activate)
	c:RegisterEffect(e1)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85119159,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,85119160)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c85119159.target)
	e2:SetOperation(c85119159.operation)
	c:RegisterEffect(e2)
end
function c85119159.filter(c)
	return c:IsAbleToHand() and c:IsSetCard(0x13a) and not c:IsCode(85119159)
end
function c85119159.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c85119159.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(85119159,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c85119159.filter1(c)
	return c:IsFaceup() and c:GetLevel()>0 and c:IsSetCard(0x8f,0x54,0x59,0x82)
end
function c85119159.filter2(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c85119159.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c85119159.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c85119159.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c85119159.filter2,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c85119159.filter1,tp,LOCATION_MZONE,0,1,1,nil)
end
function c85119159.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local g=Duel.GetMatchingGroup(c85119159.filter2,tp,LOCATION_MZONE,0,tc)
		local lc=g:GetFirst()
		local lv=tc:GetLevel()
		while lc do
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_CHANGE_LEVEL)
			e2:SetValue(lv)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			lc:RegisterEffect(e2)
			lc=g:GetNext()
		end
	end
end
