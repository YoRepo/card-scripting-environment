--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 银河女王之光  (ID: 52340274)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 123
--
-- Effect Text:
-- ①：以自己场上1只7星以上的怪兽为对象才能发动。自己场上的全部怪兽的等级直到回合结束时变成和作为对象的怪兽相同等级。
--[[ __CARD_HEADER_END__ ]]

--ギャラクシー・クィーンズ・ライト
function c52340274.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c52340274.target)
	e1:SetOperation(c52340274.activate)
	c:RegisterEffect(e1)
end
function c52340274.filter1(c)
	return c:IsFaceup() and c:IsLevelAbove(7)
end
function c52340274.filter2(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c52340274.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c52340274.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c52340274.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c52340274.filter2,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c52340274.filter1,tp,LOCATION_MZONE,0,1,1,nil)
end
function c52340274.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local g=Duel.GetMatchingGroup(c52340274.filter2,tp,LOCATION_MZONE,0,tc)
		local lc=g:GetFirst()
		local lv=tc:GetLevel()
		while lc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(lv)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			lc:RegisterEffect(e1)
			lc=g:GetNext()
		end
	end
end
