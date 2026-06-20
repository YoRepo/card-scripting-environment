--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 超重武者 御助-K  (ID: 44891812)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 154
--
-- Effect Text:
-- ①：自己墓地没有魔法·陷阱卡存在的场合，自己的守备表示怪兽和对方怪兽进行战斗的伤害计算时把这张卡从手卡丢弃，以进行战斗的怪兽以外的自己场上1只「超重武者」怪兽为对象才能发动。那只进行战斗的自己怪兽的守
-- 备力只在那次伤害计算时上升作为对象的怪兽的守备力数值。
-- ②：对方怪兽的直接攻击宣言时，把墓地的这张卡除外，以自己墓地1只「超重武者」怪兽为对象才能发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--超重武者オタス－K
function c44891812.initial_effect(c)
	--def up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44891812,0))
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c44891812.defcon)
	e1:SetCost(c44891812.defcost)
	e1:SetTarget(c44891812.deftg)
	e1:SetOperation(c44891812.defop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44891812,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c44891812.spcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c44891812.sptg)
	e2:SetOperation(c44891812.spop)
	c:RegisterEffect(e2)
end
function c44891812.defcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SPELL+TYPE_TRAP)==0
end
function c44891812.defcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c44891812.deffilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9a) and aux.nzdef(c)
end
function c44891812.deftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	local d=a:GetBattleTarget()
	if a:IsControler(1-tp) then a,d=d,a end
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp)
		and c44891812.deffilter(chkc) and chkc~=e:GetLabelObject() end
	if chk==0 then return a and a:IsDefensePos() and d and d:IsControler(1-tp)
		and Duel.IsExistingTarget(c44891812.deffilter,tp,LOCATION_MZONE,0,1,a) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44891812.deffilter,tp,LOCATION_MZONE,0,1,1,a)
	e:SetLabelObject(a)
end
function c44891812.defop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ac=e:GetLabelObject()
	if ac:IsRelateToBattle() and ac:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetValue(tc:GetDefense())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		ac:RegisterEffect(e1)
	end
end
function c44891812.spcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c44891812.spfilter(c,e,tp)
	return c:IsSetCard(0x9a) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44891812.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp)
		and c44891812.spfilter(chkc,e,tp) and chkc~=c end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c44891812.spfilter,tp,LOCATION_GRAVE,0,1,c,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c44891812.spfilter,tp,LOCATION_GRAVE,0,1,1,c,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c44891812.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
