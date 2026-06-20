--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 地底之阿剌克涅  (ID: 63465535)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Insect
-- Level 6
-- ATK 2400 | DEF 1200
--
-- Effect Text:
-- 暗属性调整＋调整以外的昆虫族怪兽1只
-- 这张卡攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。1回合1次，可以选择对方场上表侧表示存在的1只怪兽当作装备卡使用只有1只给这张卡装备。这张卡被战斗破坏的场合，可以作为代替把这个效果装备的
-- 怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--地底のアラクネー
function c63465535.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),aux.NonTuner(Card.IsRace,RACE_INSECT),1,1)
	c:EnableReviveLimit()
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c63465535.aclimit)
	e1:SetCondition(c63465535.actcon)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(63465535,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c63465535.eqcon)
	e2:SetTarget(c63465535.eqtg)
	e2:SetOperation(c63465535.eqop)
	c:RegisterEffect(e2)
	--Destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetTarget(c63465535.desreptg)
	e3:SetOperation(c63465535.desrepop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c63465535.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c63465535.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c63465535.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=e:GetLabelObject()
	return ec==nil or not ec:IsHasCardTarget(c) or ec:GetFlagEffect(63465535)==0
end
function c63465535.filter(c)
	return c:IsFaceup() and c:IsAbleToChangeControler()
end
function c63465535.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c63465535.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c63465535.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c63465535.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c63465535.eqlimit(e,c)
	return e:GetOwner()==c
end
function c63465535.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsType(TYPE_MONSTER) then
		if not Duel.Equip(tp,tc,c,false) then return end
		--Add Equip limit
		tc:RegisterFlagEffect(63465535,RESET_EVENT+RESETS_STANDARD,0,0)
		e:SetLabelObject(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c63465535.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c63465535.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ec=e:GetLabelObject():GetLabelObject()
	if chk==0 then return c:IsReason(REASON_BATTLE) and ec and ec:IsHasCardTarget(c)
		and ec:IsDestructable(e) and not ec:IsStatus(STATUS_DESTROY_CONFIRMED) and ec:GetFlagEffect(63465535)~=0 end
	return Duel.SelectEffectYesNo(tp,c,96)
end
function c63465535.desrepop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetLabelObject():GetLabelObject(),REASON_EFFECT+REASON_REPLACE)
end
