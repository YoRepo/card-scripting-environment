--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 转生炎兽的炎阵  (ID: 52155219)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 281
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：可以从以下效果选择1个发动。
-- ●从卡组把1只「转生炎兽」怪兽加入手卡。
-- ●以用和自身同名的怪兽为素材作连接召唤的自己场上1只「转生炎兽」连接怪兽为对象才能发动。这个回合，那只连接怪兽不受自身以外的怪兽的效果影响。
--[[ __CARD_HEADER_END__ ]]

--転生炎獣の炎陣
function c52155219.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,52155219+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c52155219.target)
	e1:SetOperation(c52155219.activate)
	c:RegisterEffect(e1)
	if not c52155219.global_check then
		c52155219.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
		ge1:SetCode(EFFECT_MATERIAL_CHECK)
		ge1:SetValue(c52155219.valcheck)
		Duel.RegisterEffect(ge1,0)
	end
end
function c52155219.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsLinkCode,1,nil,c:GetCode()) then
		c:RegisterFlagEffect(52155219,RESET_EVENT+0x4fe0000,0,1)
	end
end
function c52155219.thfilter(c)
	return c:IsSetCard(0x119) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c52155219.immfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x119) and c:IsSummonType(SUMMON_TYPE_LINK) and c:GetFlagEffect(52155219)~=0
end
function c52155219.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c52155219.immfilter(chkc) end
	local b1=Duel.IsExistingMatchingCard(c52155219.thfilter,tp,LOCATION_DECK,0,1,nil)
	local b2=Duel.IsExistingTarget(c52155219.immfilter,tp,LOCATION_MZONE,0,1,nil)
	if chk==0 then return b1 or b2 end
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(52155219,0),aux.Stringid(52155219,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(52155219,0))
	else
		op=Duel.SelectOption(tp,aux.Stringid(52155219,1))+1
	end
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
		e:SetProperty(0)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	else
		e:SetCategory(0)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		Duel.SelectTarget(tp,c52155219.immfilter,tp,LOCATION_MZONE,0,1,1,nil)
	end
end
function c52155219.activate(e,tp,eg,ep,ev,re,r,rp)
	local op=e:GetLabel()
	if op==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c52155219.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	else
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_IMMUNE_EFFECT)
			e1:SetValue(c52155219.efilter)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
		end
	end
end
function c52155219.efilter(e,re)
	return e:GetHandler()~=re:GetOwner() and re:IsActiveType(TYPE_MONSTER)
end
