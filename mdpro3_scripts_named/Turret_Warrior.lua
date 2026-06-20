--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 炮塔战士  (ID: 88559132)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 5
-- ATK 1200 | DEF 2000
-- Setcode: 102
--
-- Effect Text:
-- 这张卡可以把自己场上存在的1只战士族怪兽解放，从手卡特殊召唤。这个方法特殊召唤的这张卡的攻击力上升解放怪兽的原本攻击力的数值。
--[[ __CARD_HEADER_END__ ]]

--ターレット・ウォリアー
function c88559132.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c88559132.spcon)
	e1:SetTarget(c88559132.sptg)
	e1:SetOperation(c88559132.spop)
	c:RegisterEffect(e1)
end
function c88559132.spfilter(c,tp)
	return c:IsRace(RACE_WARRIOR)
		and Duel.GetMZoneCount(tp,c)>0 and (c:IsControler(tp) or c:IsFaceup())
end
function c88559132.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroupEx(tp,c88559132.spfilter,1,REASON_SPSUMMON,false,nil,tp)
end
function c88559132.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON):Filter(c88559132.spfilter,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c88559132.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=e:GetLabelObject()
	Duel.Release(tc,REASON_SPSUMMON)
	local atk=tc:GetBaseAttack()
	if atk<0 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
