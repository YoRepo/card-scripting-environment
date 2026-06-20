--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 机壳汇编器 不安定  (ID: 51194046)
-- Type: Monster / Normal / Pendulum
-- Attribute: EARTH
-- Race: Machine
-- Level 5
-- Pendulum Scales: L1 / R1
-- ATK 2400 | DEF 1000
-- Setcode: 170
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：自己不是「机壳」怪兽不能特殊召唤。这个效果不会被无效化。
-- ②：自己上级召唤成功的回合的结束阶段才能发动。自己从卡组抽出这个回合自己为上级召唤而解放的「机壳」怪兽的数量。
-- 【怪兽描述】
-- qliphoth.exe 中的 0x1i-666 确认到未处理的异常。
-- 写入位置 0x00-000 时发生访问冲突。
-- 您想忽略此错误并尝试继续吗? <Y/N>...[ ]
-- ===CARNAGE===
-- 恶gn善iod道ru知能oy似no相yr们gn我a与s经i已do人G那
-- 着doo活lfe远永rif就g吃n子i果r的b树o命t生t摘又n手a伸w他怕d恐n在a现
--[[ __CARD_HEADER_END__ ]]

--クリフォート・アセンブラ
function c51194046.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c51194046.splimit)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(51194046,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c51194046.drcon)
	e3:SetTarget(c51194046.drtg)
	e3:SetOperation(c51194046.drop)
	c:RegisterEffect(e3)
	if not c51194046.global_check then
		c51194046.global_check=true
		c51194046[0]=0
		c51194046[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c51194046.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_MSET)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD)
		ge3:SetCode(EFFECT_MATERIAL_CHECK)
		ge3:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
		ge3:SetValue(c51194046.valcheck)
		Duel.RegisterEffect(ge3,0)
		ge1:SetLabelObject(ge3)
		ge2:SetLabelObject(ge3)
		local ge4=Effect.CreateEffect(c)
		ge4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge4:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge4:SetOperation(c51194046.clearop)
		Duel.RegisterEffect(ge4,0)
	end
end
function c51194046.splimit(e,c)
	return not c:IsSetCard(0xaa)
end
function c51194046.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsSummonType(SUMMON_TYPE_ADVANCE) then
		local p=tc:GetSummonPlayer()
		c51194046[p]=c51194046[p]+e:GetLabelObject():GetLabel()
	end
end
function c51194046.valcheck(e,c)
	local ct=c:GetMaterial():FilterCount(Card.IsSetCard,nil,0xaa)
	e:SetLabel(ct)
end
function c51194046.clearop(e,tp,eg,ep,ev,re,r,rp)
	c51194046[0]=0
	c51194046[1]=0
end
function c51194046.drcon(e,tp,eg,ep,ev,re,r,rp)
	return c51194046[tp]>0
end
function c51194046.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,c51194046[tp]) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,c51194046[tp])
end
function c51194046.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,c51194046[tp],REASON_EFFECT)
end
