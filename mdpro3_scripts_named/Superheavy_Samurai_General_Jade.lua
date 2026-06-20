--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 超重辉将 翡翠-E  (ID: 42880485)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Machine
-- Level 8
-- Pendulum Scales: L1 / R1
-- ATK 1800 | DEF 2800
-- Setcode: 154
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：自己不是「超重武者」怪兽不能灵摆召唤。这个效果不会被无效化。
-- ②：1回合1次，以自己场上1只「超重武者」怪兽为对象才能发动。那只怪兽的等级上升1星。
-- 【怪兽效果】
-- 这张卡在规则上也当作「超重武者」卡使用。这张卡可以把1只「超重武者」怪兽解放作上级召唤。
-- ①：这张卡召唤·特殊召唤成功时才能发动。这张卡的表示形式变更。
-- ②：这张卡可以用表侧守备表示的状态作出攻击。那个场合，这张卡用守备力当作攻击力使用进行伤害计算。
--[[ __CARD_HEADER_END__ ]]

--超重輝将ヒス－E
function c42880485.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetTargetRange(1,0)
	e2:SetCondition(c42880485.splimcon)
	e2:SetTarget(c42880485.splimit)
	c:RegisterEffect(e2)
	--level
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_PZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetTarget(c42880485.lvtg)
	e3:SetOperation(c42880485.lvop)
	c:RegisterEffect(e3)
	--pos
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_POSITION)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetTarget(c42880485.postg)
	e4:SetOperation(c42880485.posop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)
	--normal summon with 1 tribute
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(42880485,0))
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_SUMMON_PROC)
	e6:SetCondition(c42880485.otcon)
	e6:SetOperation(c42880485.otop)
	e6:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e7)
	--
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_DEFENSE_ATTACK)
	e8:SetValue(1)
	c:RegisterEffect(e8)
end
function c42880485.splimcon(e)
	return not e:GetHandler():IsForbidden()
end
function c42880485.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x9a) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c42880485.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9a) and c:GetLevel()>0
end
function c42880485.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c42880485.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c42880485.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c42880485.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c42880485.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c42880485.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c42880485.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
function c42880485.otfilter(c,tp)
	return c:IsSetCard(0x9a) and (c:IsControler(tp) or c:IsFaceup())
end
function c42880485.otcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c42880485.otfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	return c:IsLevelAbove(7) and minc<=1 and Duel.CheckTribute(c,1,1,mg)
end
function c42880485.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c42880485.otfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
