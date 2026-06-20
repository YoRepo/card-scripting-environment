--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 灵魂交错  (ID: 68005187)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡发动的回合，自己不能进行战斗阶段。
-- ①：以对方场上1只怪兽为对象才能发动。这个回合，自己把怪兽解放的场合，必须作为自己场上1只怪兽的代替而把作为对象的对方怪兽解放。
--[[ __CARD_HEADER_END__ ]]

--クロス・ソウル
function c68005187.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c68005187.cost)
	e1:SetTarget(c68005187.target)
	e1:SetOperation(c68005187.activate)
	c:RegisterEffect(e1)
end
function c68005187.filter(c)
	return not (c:IsHasEffect(EFFECT_UNRELEASABLE_SUM) and c:IsHasEffect(EFFECT_UNRELEASABLE_NONSUM))
end
function c68005187.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCurrentPhase()~=PHASE_MAIN2 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c68005187.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c68005187.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c68005187.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c68005187.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c68005187.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_RELEASE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
