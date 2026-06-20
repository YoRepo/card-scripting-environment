--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 二重曝光  (ID: 81881839)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：以场上2只6星以下的同名怪兽为对象才能发动。那些怪兽的等级变成2倍。
-- ②：自己·对方的战斗阶段开始时，以自己场上1只「光波」怪兽为对象才能发动。选那只怪兽以外的场上1只表侧表示怪兽，直到结束阶段那个卡名当作和作为对象的「光波」怪兽同名卡使用。
--[[ __CARD_HEADER_END__ ]]

--二重露光
function c81881839.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--lv
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(81881839,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,81881839)
	e2:SetTarget(c81881839.lvtg)
	e2:SetOperation(c81881839.lvop)
	c:RegisterEffect(e2)
	--name
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(81881839,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,81881840)
	e3:SetTarget(c81881839.nametg)
	e3:SetOperation(c81881839.nameop)
	c:RegisterEffect(e3)
end
function c81881839.lvfilter(c,e)
	return c:IsFaceup() and c:IsLevelBelow(6) and c:IsCanBeEffectTarget(e)
end
function c81881839.fselect(g)
	return g:GetClassCount(Card.GetCode)==1
end
function c81881839.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetMatchingGroup(c81881839.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
	if chkc then return false end
	if chk==0 then return g:CheckSubGroup(c81881839.fselect,2,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local sg=g:SelectSubGroup(tp,c81881839.fselect,false,2,2)
	Duel.SetTargetCard(sg)
end
function c81881839.tgfilter(c,e)
	return c:IsFaceup() and c:IsRelateToEffect(e)
end
function c81881839.lvop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c81881839.tgfilter,nil,e)
	if g:GetCount()<=0 then return end
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c81881839.namefilter(c,code)
	return c:IsFaceup() and not c:IsCode(code)
end
function c81881839.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xe5)
		and Duel.IsExistingMatchingCard(c81881839.namefilter,0,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetCode())
end
function c81881839.nametg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c81881839.cfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81881839.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(81881839,2))
	Duel.SelectTarget(tp,c81881839.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c81881839.nameop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local code=tc:GetCode()
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(81881839,3))
		local g=Duel.SelectMatchingCard(tp,c81881839.namefilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc,code)
		local sc=g:GetFirst()
		if sc then
			Duel.HintSelection(g)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_CODE)
			e1:SetValue(tc:GetCode())
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			sc:RegisterEffect(e1)
		end
	end
end
