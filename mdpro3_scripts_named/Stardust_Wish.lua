--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 星尘的祈愿  (ID: 35129241)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 163
--
-- Effect Text:
-- ①：1回合1次，自己场上的「星尘」同调怪兽为让自身的效果发动而被解放的场合，以那1只怪兽为对象才能发动。那只怪兽特殊召唤。对方不能对应这个效果的发动把魔法·陷阱·怪兽的效果发动。
-- ②：这张卡的①的效果特殊召唤的怪兽在攻击表示的场合不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--星屑の願い
function c35129241.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_RELEASE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1)
	e2:SetTarget(c35129241.target)
	e2:SetOperation(c35129241.activate)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c35129241.indtg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c35129241.filter(c,e,tp,re)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsSetCard(0xa3) and c:IsType(TYPE_SYNCHRO) and c:IsReason(REASON_COST) and c==re:GetHandler()
		and c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c35129241.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return eg:IsExists(c35129241.filter,1,nil,e,tp,re)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	local tg
	if #eg==1 then
		tg=eg:Clone()
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		tg=eg:FilterSelect(tp,c35129241.filter,1,1,nil,e,tp,re)
	end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tg,1,0,0)
	Duel.SetChainLimit(c35129241.chlimit)
end
function c35129241.chlimit(e,ep,tp)
	return tp==ep
end
function c35129241.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		tc:RegisterFlagEffect(35129241,RESET_EVENT+RESETS_STANDARD,0,1,e:GetHandler():GetFieldID())
	end
end
function c35129241.indtg(e,c)
	return c:IsAttackPos() and c:GetFlagEffectLabel(35129241)==e:GetHandler():GetFieldID()
end
