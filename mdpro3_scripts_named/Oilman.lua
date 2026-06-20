--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 汽油侠  (ID: 31768112)
-- Type: Monster / Effect / Union
-- Attribute: EARTH
-- Race: Machine
-- Level 2
-- ATK 400 | DEF 400
--
-- Effect Text:
-- 1回合1次，自己的主要阶段时可以当作装备卡使用给自己场上的机械族怪兽装备，或者把装备解除以表侧攻击表示特殊召唤。只在这个效果当作装备卡使用的场合，装备怪兽战斗破坏对方怪兽的场合，从卡组抽1张卡。（1只
-- 怪兽可以装备的同盟最多1张。装备怪兽被破坏的场合，作为代替把这张卡破坏。）
--[[ __CARD_HEADER_END__ ]]

--オイルメン
function c31768112.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31768112,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c31768112.eqtg)
	e1:SetOperation(c31768112.eqop)
	c:RegisterEffect(e1)
	--unequip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(31768112,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(aux.IsUnionState)
	e2:SetTarget(c31768112.sptg)
	e2:SetOperation(c31768112.spop)
	c:RegisterEffect(e2)
	--destroy sub
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e3:SetCondition(aux.IsUnionState)
	e3:SetValue(aux.UnionReplaceFilter)
	c:RegisterEffect(e3)
	--draw
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(31768112,2))
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c31768112.drcon)
	e4:SetTarget(c31768112.drtg)
	e4:SetOperation(c31768112.drop)
	c:RegisterEffect(e4)
	--eqlimit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_UNION_LIMIT)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetValue(c31768112.eqlimit)
	c:RegisterEffect(e5)
end
c31768112.old_union=true
function c31768112.eqlimit(e,c)
	return c:IsRace(RACE_MACHINE)
end
function c31768112.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:GetUnionCount()==0
end
function c31768112.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c31768112.filter(chkc) end
	if chk==0 then return e:GetHandler():GetFlagEffect(31768112)==0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c31768112.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c31768112.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(31768112,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c31768112.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	if not tc:IsRelateToEffect(e) or not c31768112.filter(tc) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	if not Duel.Equip(tp,c,tc,false) then return end
	aux.SetUnionState(c)
end
function c31768112.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(31768112)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():RegisterFlagEffect(31768112,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c31768112.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_ATTACK)
end
function c31768112.drcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.IsUnionState(e) and e:GetHandler():GetEquipTarget()==eg:GetFirst()
end
function c31768112.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c31768112.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
