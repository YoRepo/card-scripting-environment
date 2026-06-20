--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 盟军·次世代三力人  (ID: 52709508)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Machine
-- Level 7
-- ATK 2500 | DEF 2100
-- Setcode: 2
--
-- Effect Text:
-- 「次世代」调整＋调整以外的怪兽1只以上
-- ①：这张卡得到作为这张卡的同调素材的除调整以外的怪兽属性的以下效果。
-- ●地：这张卡攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
-- ●炎：这张卡战斗破坏怪兽的场合发动。给与对方那只怪兽的原本攻击力数值的伤害。
-- ●光：1回合1次，以自己墓地1只光属性怪兽为对象才能发动。那只光属性怪兽里侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--A・ジェネクス・トライフォース
function c52709508.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x2),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--mat check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c52709508.valcheck)
	c:RegisterEffect(e1)
	--synchro success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c52709508.regcon)
	e2:SetOperation(c52709508.regop)
	c:RegisterEffect(e2)
	e2:SetLabelObject(e1)
end
function c52709508.valcheck(e,c)
	local g=c:GetMaterial()
	local att=0
	local tc=g:GetFirst()
	while tc do
		if not tc:IsType(TYPE_TUNER) then
			att=bit.bor(att,tc:GetAttribute())
		end
		tc=g:GetNext()
	end
	att=bit.band(att,0x15)
	e:SetLabel(att)
end
function c52709508.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
		and e:GetLabelObject():GetLabel()~=0
end
function c52709508.regop(e,tp,eg,ep,ev,re,r,rp)
	local att=e:GetLabelObject():GetLabel()
	local c=e:GetHandler()
	if bit.band(att,ATTRIBUTE_EARTH)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(0,1)
		e1:SetValue(c52709508.aclimit)
		e1:SetCondition(c52709508.actcon)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(52709508,2))
	end
	if bit.band(att,ATTRIBUTE_FIRE)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(52709508,0))
		e1:SetCategory(CATEGORY_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EVENT_BATTLE_DESTROYING)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e1:SetCondition(c52709508.damcon)
		e1:SetTarget(c52709508.damtg)
		e1:SetOperation(c52709508.damop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(52709508,3))
	end
	if bit.band(att,ATTRIBUTE_LIGHT)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(52709508,1))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCountLimit(1)
		e1:SetTarget(c52709508.sptg)
		e1:SetOperation(c52709508.spop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(52709508,4))
	end
end
function c52709508.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c52709508.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c52709508.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local t=Duel.GetAttackTarget()
	if ev==1 then t=Duel.GetAttacker() end
	e:SetLabel(t:GetAttack())
	return t:IsLocation(LOCATION_GRAVE) and t:IsType(TYPE_MONSTER)
end
function c52709508.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c52709508.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c52709508.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c52709508.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c52709508.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c52709508.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c52709508.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c52709508.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsAttribute(ATTRIBUTE_LIGHT)
		and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)>0 then
		Duel.ConfirmCards(1-tp,tc)
	end
end
