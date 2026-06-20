--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 混沌之双翼  (ID: 22850702)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Fiend
-- Level 10
-- ATK 3500 | DEF 2800
-- Setcode: 207
--
-- Effect Text:
-- 调整＋调整以外的光·暗属性怪兽1只以上
-- 这张卡同调召唤的场合，可以把自己场上1只光·暗属性怪兽当作调整使用。
-- ①：这张卡特殊召唤的场合，以场上1张卡为对象才能发动。那张卡除外。
-- ②：这张卡得到作为这张卡的同调素材的怪兽的原本属性的以下效果。
-- ●光：自己场上的同调怪兽不受对方发动的怪兽的效果影响。
-- ●暗：自己怪兽不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--カオス・アンヘル－混沌の双翼－
function c22850702.initial_effect(c)
	--synchro summon
	c:EnableReviveLimit()
	aux.AddSynchroMixProcedure(c,c22850702.matfilter1,nil,nil,c22850702.matfilter2,1,99)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22850702,2))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c22850702.rmtg)
	e1:SetOperation(c22850702.rmop)
	c:RegisterEffect(e1)
	--mat check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c22850702.valcheck)
	c:RegisterEffect(e2)
	--synchro success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCondition(c22850702.regcon)
	e3:SetOperation(c22850702.regop)
	c:RegisterEffect(e3)
	e3:SetLabelObject(e2)
end
function c22850702.matfilter1(c,syncard)
	return c:IsTuner(syncard) or c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK)
end
function c22850702.matfilter2(c,syncard)
	return c:IsNotTuner(syncard) and c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK)
end
function c22850702.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c22850702.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c22850702.valcheck(e,c)
	local g=c:GetMaterial()
	local att=0
	local tc=g:GetFirst()
	while tc do
		att=bit.bor(att,tc:GetOriginalAttribute())
		tc=g:GetNext()
	end
	e:SetLabel(att)
end
function c22850702.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
		and e:GetLabelObject():GetLabel()~=0
end
function c22850702.regop(e,tp,eg,ep,ev,re,r,rp)
	local att=e:GetLabelObject():GetLabel()
	local c=e:GetHandler()
	if bit.band(att,ATTRIBUTE_LIGHT)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_SYNCHRO))
		e1:SetValue(c22850702.efilter)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		Duel.AdjustInstantly(c)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(22850702,0))
	end
	if bit.band(att,ATTRIBUTE_DARK)~=0 then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetTargetRange(LOCATION_MZONE,0)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e2)
		Duel.AdjustInstantly(c)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(22850702,1))
	end
end
function c22850702.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer() and re:IsActivated()
		and re:IsActiveType(TYPE_MONSTER)
end
