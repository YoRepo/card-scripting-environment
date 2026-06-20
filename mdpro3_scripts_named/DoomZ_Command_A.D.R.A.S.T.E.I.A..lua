--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 终刻反转『阿德剌斯忒亚』  (ID: 84054556)
-- Type: Spell / Field
-- ATK 0 | DEF 0
-- Setcode: 466
--
-- Effect Text:
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：装备怪兽1回合只有1次不会被战斗破坏。
-- ②：自己主要阶段才能发动。装备怪兽破坏，破坏的怪兽以外的自己的手卡·墓地·除外状态的1只「终刻」怪兽守备表示特殊召唤。
-- ③：这张卡在墓地存在的场合，以自己场上1只表侧表示怪兽为对象才能发动。这张卡给那只怪兽装备。那之后，自己受到装备怪兽的等级·阶级×100伤害。
--[[ __CARD_HEADER_END__ ]]

--終刻反転『A.D.R.A.S.T.E.I.A.』
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddEquipSpellEffect(c,true,true,Card.IsFaceup,nil)
	--indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(s.valcon)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
	--equip
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_EQUIP+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,id+o)
	e3:SetTarget(s.eqtg)
	e3:SetOperation(s.eqop)
	c:RegisterEffect(e3)
end
function s.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function s.spfilter(c,e,tp)
	return c:IsFaceupEx() and c:IsSetCard(0x1d2) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=e:GetHandler():GetEquipTarget()
	if chk==0 then return ec and Duel.GetMZoneCount(tp,ec)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,ec,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	if not ec or Duel.Destroy(ec,REASON_EFFECT)==0 then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,ec,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function s.eqfilter2(c)
	return c:IsFaceup()
end
function s.lv_or_rk(c)
	if c:IsLevelAbove(1) then
		return c:GetLevel()
	elseif c:IsRankAbove(1) then
		return c:GetRank()
	else
		return 0
	end
end
function s.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.eqfilter2(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(s.eqfilter2,tp,LOCATION_MZONE,0,1,nil)
		and c:CheckUniqueOnField(tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local tc=Duel.SelectTarget(tp,s.eqfilter2,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,c,1,0,0)
	local lr=s.lv_or_rk(tc)
	if lr>0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,lr*100)
	end
end
function s.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and c:IsRelateToChain() and tc:IsRelateToChain() and tc:IsFaceup() and tc:IsType(TYPE_MONSTER)
		and aux.NecroValleyFilter()(c) and c:CheckUniqueOnField(tp)
		and Duel.Equip(tp,c,tc) and s.lv_or_rk(tc)>0 then
		Duel.BreakEffect()
		Duel.Damage(tp,s.lv_or_rk(tc)*100,REASON_EFFECT)
	end
end
