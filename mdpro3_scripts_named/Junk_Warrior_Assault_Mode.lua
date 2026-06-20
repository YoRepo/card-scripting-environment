--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 废品战士/爆裂体  (ID: 23219323)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Warrior
-- Level 7
-- ATK 2800 | DEF 1800
-- Setcode: 17931495145539
--
-- Effect Text:
-- 这张卡不能通常召唤，用「爆裂模式」的效果才能特殊召唤。
-- ①：这张卡的攻击力上升自己场上的「/爆裂体」怪兽数量×1000，这张卡用和怪兽的战斗给与对方的战斗伤害变成2倍。
-- ②：场上的这张卡不受对方发动的怪兽的效果影响。
-- ③：这张卡被破坏的场合，以自己墓地1只「废品战士」为对象才能发动。那只怪兽回到额外卡组。那之后，可以把那只怪兽当作同调召唤作特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ジャンク・ウォリアー／バスター
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,60800381,80280737)
	--Cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.AssaultModeLimit)
	c:RegisterEffect(e0)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(s.val)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(s.immval)
	c:RegisterEffect(e2)
	--toextra
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetCategory(CATEGORY_TOEXTRA+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetTarget(s.sptg)
	e3:SetOperation(s.spop)
	c:RegisterEffect(e3)
	--double
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e4:SetCondition(s.damcon)
	e4:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e4)
end
s.assault_name=60800381
function s.val(e,c)
	return Duel.GetMatchingGroupCount(s.filter,c:GetControler(),LOCATION_MZONE,0,nil)*1000
end
function s.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x104f)
end
function s.immval(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer() and re:IsActivated()
		and re:IsActiveType(TYPE_MONSTER)
end
function s.spfilter(c,e,tp)
	return c:IsCode(60800381) and c:IsType(TYPE_SYNCHRO) and c:IsAbleToExtra() and c:GetOwner()==tp
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and s.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(s.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,s.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToChain()
		and aux.NecroValleyFilter()(tc) and Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)>0
		and tc:IsLocation(LOCATION_EXTRA)
		and tc:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,tc)>0
		and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		Duel.BreakEffect()
		tc:SetMaterial(nil)
		Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
function s.damcon(e)
	return e:GetHandler():GetBattleTarget()~=nil
end
