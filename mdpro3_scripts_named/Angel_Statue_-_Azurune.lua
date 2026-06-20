--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 碑像天使-亚兹卢恩死月弓碑  (ID: 44822037)
-- Type: Trap / Equip
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1800 | DEF 1800
--
-- Effect Text:
-- ①：这张卡发动后变成效果怪兽（天使族·光·4星·攻/守1800）在怪兽区域特殊召唤（也当作陷阱卡使用）。
-- ②：这张卡是已用这张卡的效果特殊召唤的场合，1回合1次，对方把怪兽特殊召唤之际，把从魔法与陷阱区域特殊召唤的自己的怪兽区域1张永续陷阱卡送去墓地才能发动。那次特殊召唤无效，那些怪兽破坏。
-- ③：这张卡被战斗破坏时才能发动。把让这张卡破坏的怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--碑像の天使－アズルーン
function c44822037.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c44822037.target)
	e1:SetOperation(c44822037.activate)
	c:RegisterEffect(e1)
	--disable special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44822037,0))
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_SPSUMMON)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c44822037.discon)
	e2:SetCost(c44822037.discost)
	e2:SetTarget(c44822037.distg)
	e2:SetOperation(c44822037.disop)
	c:RegisterEffect(e2)
	--destory
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(44822037,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetTarget(c44822037.destg)
	e3:SetOperation(c44822037.desop)
	c:RegisterEffect(e3)
end
function c44822037.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,44822037,0,TYPES_EFFECT_TRAP_MONSTER,1800,1800,4,RACE_FAIRY,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c44822037.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,44822037,0,TYPES_EFFECT_TRAP_MONSTER,1800,1800,4,RACE_FAIRY,ATTRIBUTE_LIGHT) then return end
	c:AddMonsterAttribute(TYPE_EFFECT+TYPE_TRAP)
	Duel.SpecialSummon(c,SUMMON_VALUE_SELF,tp,tp,true,false,POS_FACEUP)
end
function c44822037.discon(e,tp,eg,ep,ev,re,r,rp)
	local se=e:GetHandler():GetSpecialSummonInfo(SUMMON_INFO_REASON_EFFECT)
	return tp~=ep and Duel.GetCurrentChain()==0 and se and se:GetHandler()==e:GetHandler()
end
function c44822037.discfilter(c)
	return c:IsFaceup() and c:IsAbleToGraveAsCost() and c:IsSummonLocation(LOCATION_SZONE) and (c:GetType()&(TYPE_TRAP+TYPE_CONTINUOUS))==TYPE_TRAP+TYPE_CONTINUOUS
end
function c44822037.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44822037.discfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44822037.discfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c44822037.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c44822037.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
function c44822037.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	if chk==0 then return tc and tc:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c44822037.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc and tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
