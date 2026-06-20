--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 不期而遇-妨“艾”-  (ID: 6552971)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 310
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把手卡·额外卡组1只攻击力2300的电子界族怪兽给对方观看，把持有和那只怪兽相同属性的1只「@火灵天星」怪兽从卡组加入手卡。发动后，这个回合中自己对这个效果给人观看的怪兽或者那些同名怪兽的特殊召唤
-- 没有成功的场合，结束阶段让自己受到2300伤害。这张卡的发动后，直到回合结束时自己不能把电子界族以外的怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--めぐり－Ai－
function c6552971.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,6552971+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c6552971.target)
	e1:SetOperation(c6552971.activate)
	c:RegisterEffect(e1)
end
function c6552971.chkfilter(c,tp)
	return c:IsRace(RACE_CYBERSE) and c:GetAttack()==2300 and not c:IsPublic()
		and Duel.IsExistingMatchingCard(c6552971.thfilter,tp,LOCATION_DECK,0,1,nil,c:GetAttribute())
end
function c6552971.thfilter(c,att)
	return c:IsSetCard(0x135) and c:IsAttribute(att) and c:IsAbleToHand()
end
function c6552971.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6552971.chkfilter,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6552971.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local rc=Duel.SelectMatchingCard(tp,c6552971.chkfilter,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,1,nil,tp):GetFirst()
	if rc then
		local att=rc:GetAttribute()
		Duel.ConfirmCards(1-tp,rc)
		if rc:IsLocation(LOCATION_HAND) then Duel.ShuffleHand(tp) end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_SPSUMMON_SUCCESS)
		e1:SetLabel(rc:GetCode())
		e1:SetOperation(c6552971.regop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetReset(RESET_PHASE+PHASE_END)
		e2:SetCondition(c6552971.damcon)
		e2:SetOperation(c6552971.damop)
		e2:SetLabelObject(e1)
		Duel.RegisterEffect(e2,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c6552971.thfilter,tp,LOCATION_DECK,0,1,1,nil,att)
		if #g>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetTargetRange(1,0)
	e3:SetValue(c6552971.actlimit)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c6552971.regfilter(c,tp,code)
	return c:IsSummonPlayer(tp) and c:IsCode(code)
end
function c6552971.regop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then return end
	if eg:IsExists(c6552971.regfilter,1,nil,tp,e:GetLabel()) then
		e:SetLabel(0)
	end
end
function c6552971.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetLabel()~=0
end
function c6552971.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,2300,REASON_EFFECT)
end
function c6552971.actlimit(e,re,rp)
	local rc=re:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and not rc:IsRace(RACE_CYBERSE)
end
